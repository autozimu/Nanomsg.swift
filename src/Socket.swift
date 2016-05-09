import CNanomsg

public class Socket {
    enum Domain: CInt {
        case AF_SP = 1
        case AF_SP_RAW = 2
    }

    enum Proto: CInt {
        // bus.h
        case BUS = 112

        // inproc.h
        case INPROC = -1

        // pair.h
        case PAIR = 16

        // pipeline.h
        case PUSH = 80
        case PULL = 81

        // pubsub.h
        case PUB = 32
        case SUB = 33

        // reqrep.h
        case REQ = 48
        case REP = 49

        // survey.h
        case SURVEYOR = 98
        case RESPONDENT = 99

        // tcp.h
        case TCP = -3
        case TCP_NODELAY = 1

        // tcpmux.h
        case TCPMUX = -5
        // not unique raw value?
        // case TCPMUX_NODELAY = 1

        // ws.h
        case WS = -4
    }

    let domain: Domain
    let proto: Proto
    var socketid: CInt = -1

    init(_ domain: Domain, _ proto: Proto) throws {
        self.domain = domain
        self.proto = proto

        socketid = nn_socket(domain.rawValue, proto.rawValue)
        if socketid < 0 {
            throw NanomsgError.Err(msg: strerror)
        }
    }

    deinit {
        do {
            try close()
        } catch NanomsgError.Err(let msg) {
            print(msg)
        } catch {
            print("Unknown error occured")
        }
    }

    // Close an SP Socket
    func close() throws {
        let ret = nn_close(socketid)
        if ret < 0 {
            throw NanomsgError.Err(msg: strerror)
        }
    }

    // Add a local endpoint to the socket.
    func bind(_ addr: String) throws -> CInt {
        var eid: CInt = -1
        addr.withCString { caddr in
            eid = nn_bind(socketid, caddr)
        }
        if eid < 0 {
            throw NanomsgError.Err(msg: strerror)
        }
        return eid
    }

    // Add a remote endpoint to the socket.
    func connect(_ addr: String) throws -> CInt {
        var eid: CInt = -1
        addr.withCString { caddr in
            eid = nn_connect(socketid, caddr)
        }
        if eid < 0 {
            throw NanomsgError.Err(msg: strerror)
        }
        return eid
    }

    // Remove an endpoint from the socket.
    func shutdown(eid: CInt) throws {
        let ret = nn_shutdown(socketid, eid)
        if ret < 0 {
            throw NanomsgError.Err(msg: strerror)
        }
    }

    // Send a message.
    func send(_ msg: [UInt8], flags: CInt = 0) throws -> CInt {
        let sz_msg = msg.count
        var nSent: CInt = 0

        nSent = nn_send(socketid, msg, sz_msg, flags)
        if nSent < 0 {
            throw NanomsgError.Err(msg: strerror)
        }

        return nSent
    }

    // Send a string.
    func send(_ msg: String, flags: CInt = 0) throws -> CInt {
        let sz_msg = msg.characters.count + 1
        var nSent : CInt = 0

        nSent = nn_send(socketid, msg, sz_msg, flags)
        if nSent < 0 {
            throw NanomsgError.Err(msg: strerror)
        }

        return nSent
    }

    // Receive a message.
    func recv(flags: CInt = 0) throws -> UnsafeMutableBufferPointer<UInt8> {
        let p = UnsafeMutablePointer<UInt8>(allocatingCapacity: 1)
        let pp = UnsafeMutablePointer<UnsafeMutablePointer<UInt8>>(allocatingCapacity: 1)
        pp.pointee = p;
        let nRecv = nn_recv(socketid, p, NN_MSG, flags)
        if nRecv < 0 {
            throw NanomsgError.Err(msg: strerror)
        }

        return UnsafeMutableBufferPointer(start: p, count: Int(nRecv))
    }

    // Receive a string.
    func recvstr(flags: CInt = 0) throws -> String? {
        if let cstr = try recv(flags: flags).baseAddress {
            return String(cString: UnsafePointer<CChar>(cstr))
        } else {
            return nil
        }
    }

    // Fine-grained alternative to send.
    func sendmsg() {
        // TODO
    }

    // Find-grained alternative to recv.
    func recvmsg() {
        // TODO
    }

    // Start a device.
    func device(anotherSock: Socket) throws {
        let ret = nn_device(socketid, anotherSock.socketid)
        if ret < 0 {
            throw NanomsgError.Err(msg: strerror)
        }
    }

    // Notify all sockets about process termination.
    func term() {
        nn_term()
    }
}

