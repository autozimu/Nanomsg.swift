import CNanomsg

public class Socket {
    let domain: Domain
    let proto: Proto
    var socketid: CInt = -1

    public init(_ domain: Domain, _ proto: Proto) throws {
        self.domain = domain
        self.proto = proto

        socketid = nn_socket(domain.rawValue, proto.rawValue)
        if socketid < 0 {
            throw NanomsgError()
        }
    }

    public convenience init(_ proto: Proto) throws {
        try self.init(.AF_SP, proto)
    }

    deinit {
        do {
            try close()
        } catch NanomsgError.Err(let errno, let msg) {
            print(errno, msg)
        } catch {
            print("Unknown error occured")
        }
    }

    // Close an SP Socket
    public func close() throws {
        let ret = nn_close(socketid)
        if ret < 0 {
            throw NanomsgError()
        }
    }

    // Add a local endpoint to the socket.
    public func bind(_ addr: String) throws -> CInt {
        var eid: CInt = -1
        addr.withCString { caddr in
            eid = nn_bind(socketid, caddr)
        }
        if eid < 0 {
            throw NanomsgError()
        }
        return eid
    }

    // Add a remote endpoint to the socket.
    public func connect(_ addr: String) throws -> CInt {
        var eid: CInt = -1
        addr.withCString { caddr in
            eid = nn_connect(socketid, caddr)
        }
        if eid < 0 {
            throw NanomsgError()
        }
        return eid
    }

    // Remove an endpoint from the socket.
    public func shutdown(eid: CInt) throws {
        let ret = nn_shutdown(socketid, eid)
        if ret < 0 {
            throw NanomsgError()
        }
    }

    // Send a message.
    public func send(_ msg: [UInt8], flags: Flags = .None) throws -> CInt {
        let sz_msg = msg.count
        var nSent: CInt = 0

        nSent = nn_send(socketid, msg, sz_msg, flags.rawValue)
        if nSent < 0 {
            throw NanomsgError()
        }

        return nSent
    }

    // Send a string.
    public func send(_ msg: String, flags: Flags = .None) throws -> CInt {
        let sz_msg = msg.characters.count + 1
        var nSent : CInt = 0

        nSent = nn_send(socketid, msg, sz_msg, flags.rawValue)
        if nSent < 0 {
            throw NanomsgError()
        }

        return nSent
    }

    // Receive a message.
    public func recv(flags: Flags = .None) throws -> UnsafeMutableBufferPointer<UInt8> {
        let p = UnsafeMutablePointer<UInt8>(allocatingCapacity: 1)
        let pp = UnsafeMutablePointer<UnsafeMutablePointer<UInt8>>(allocatingCapacity: 1)
        pp.pointee = p;
        let nRecv = nn_recv(socketid, p, NN_MSG, flags.rawValue)
        if nRecv < 0 {
            throw NanomsgError()
        }

        return UnsafeMutableBufferPointer(start: p, count: Int(nRecv))
    }

    // Receive a string.
    public func recvstr(flags: Flags = .None) throws -> String? {
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
    public func device(anotherSock: Socket) throws {
        let ret = nn_device(socketid, anotherSock.socketid)
        if ret < 0 {
            throw NanomsgError()
        }
    }

    // Notify all sockets about process termination.
    public func term() {
        nn_term()
    }
}

