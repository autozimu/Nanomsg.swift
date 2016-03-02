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

    func bind(addr: String) {
        addr.withCString { caddr in
            eid = nn_bind(socketid, caddr)
            assert(eid >= 0)
        }
    }

    func connect(addr: String) {
        addr.withCString { caddr in
            eid = nn_connect(socketid, caddr)
            assert(eid >= 0)
        }
    }

    func shutdown() {
        nn_shutdown(socketid, eid)
    }

    func setsockopt(level: Int, option: Int, optval: Object) {
        // TODO
    }

    func getsockopt(level: Int, option: Int, optval: Object) {
        // TODO
    }

    func send(msg: String, flags: CInt = 0) -> Int {
        let sz_msg = msg.characters.count + 1
        var length = 0
        msg.withCString { cmsg in
            let bytes = nn_send(socketid, cmsg, sz_msg, flags)
            length = Int(bytes)
        }
        assert(length == sz_msg)
        return length
    }

    func recv(flags: CInt = 0) -> String? {
        let buffsize = 100
        var buff = [CChar](count: buffsize, repeatedValue: 0)
        buff.withUnsafeMutableBufferPointer { p in
            nn_recv(socketid, p.baseAddress, buffsize, flags)
        }
        return String.fromCString(buff)

        // let buff = UnsafeMutablePointer<Void>.alloc(0)
        // // NN_MSG = ((size_t) - 1)
        // // 4294967295 = 2 ^ 32 - 1
        // let bytes = nn_recv(socketid, buff, 4294967295, 0)
        // print("RECEIVED: \(bytes) bytes")
        // let str = String.fromCString(UnsafeMutablePointer<CChar>(buff))
        // // nn_freemsg(buff)
        // return str
    }

    func nn_sendmsg() {
        // TODO
    }

    func nn_redvmsg() {
        // TODO
    }
}

func strerror(errnum: Int) -> String? {
    return String.fromCString(nn_strerror(CInt(errnum)))
}
