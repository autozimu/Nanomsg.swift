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
    var eid: CInt = -1

    init(domain: Domain, proto: Proto) {
        self.domain = domain
        self.proto = proto

        socketid = nn_socket(domain.rawValue, proto.rawValue)
        assert(socketid >= 0)
    }

    deinit {
        shutdown()
    }

    // Add a local endpoint to the socket.
    func bind(addr: String) {
        addr.withCString { caddr in
            eid = nn_bind(socketid, caddr)
            assert(eid >= 0)
        }
    }

    // Add a remote endpoint to the socket.
    func connect(addr: String) {
        addr.withCString { caddr in
            eid = nn_connect(socketid, caddr)
            assert(eid >= 0)
        }
    }

    // REmove an endpoint from the socket.
    func shutdown() {
        nn_shutdown(socketid, eid)
    }

    // Set a socket option.
    func setsockopt(level: Int, option: Int, optval: AnyObject) {
        // TODO
    }

    // Retrieve a socket option.
    func getsockopt(level: Int, option: Int, optval: AnyObject) {
        // TODO
    }

    // Send a message.
    func send(msg: [UInt8], flags: CInt = 0) -> CInt {
        let msgSize = msg.count

        let sentLen = nn_send(socketid, msg, msgSize, flags)

        assert(Int(sentLen) == msgSize)
        return sentLen
    }

    // Send a string.
    func send(msg: String, flags: CInt = 0) -> CInt {
        let bytes = [UInt8](msg.utf8)
        return send(msg: bytes, flags: flags)
    }

    // Receive a message.
    func recv(flags: CInt = 0) -> String? {
        let buffsize = 100
        var buff = [CChar](repeating: 0, count: buffsize)
        buff.withUnsafeMutableBufferPointer { p in
            nn_recv(socketid, p.baseAddress, buffsize, flags)
        }
        return String(cString: buff)

        // let buff = UnsafeMutablePointer<Void>.alloc(0)
        // // NN_MSG = ((size_t) - 1)
        // // 4294967295 = 2 ^ 32 - 1
        // let bytes = nn_recv(socketid, buff, 4294967295, 0)
        // print("RECEIVED: \(bytes) bytes")
        // let str = String.fromCString(UnsafeMutablePointer<CChar>(buff))
        // // nn_freemsg(buff)
        // return str
    }

    // Fine-grained alternative to send.
    func sendmsg() {
        // TODO
    }

    // Find-grained alternative to recv.
    func recvmsg() {
        // TODO
    }
}

