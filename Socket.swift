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

        // ipc.h
        case IPC = -2

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
        case RESPODENT = 99

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
    var socket: CInt = 0

    init(domain: Domain, proto: Proto) {
        self.domain = domain
        self.proto = proto

        socket = nn_socket(domain.rawValue, proto.rawValue)
        assert(socket >= 0)
    }

    func bind(addr: String) {
        addr.withCString { caddr in
            let ret = nn_bind(socket, caddr)
            assert(ret >= 0)
        }
    }

    func connect(addr: String) {
        addr.withCString { caddr in
            let ret = nn_connect(socket, caddr)
            assert(ret >= 0)
        }
    }

    func shutdown(how: CInt) {
        nn_shutdown(socket, how)
    }

    func send(msg: String, flags: CInt = 0) -> Int {
        let sz_msg = msg.characters.count + 1
        var length = 0
        msg.withCString { cmsg in
            let bytes = nn_send(socket, cmsg, sz_msg, flags)
            length = Int(bytes)
        }
        assert(length == sz_msg)
        return length
    }

    func recv(flags: CInt = 0) -> String? {
        let buf = nn_recv_wrap(socket, flags)
        let str = String.fromCString(buf)
        nn_freemsg(buf)
        return str
    }
}
