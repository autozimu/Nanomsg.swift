import CNanomsg

public enum NanomsgError: ErrorProtocol {
    case Err(errno: CInt, msg: String)

    init() {
        let errno = nn_errno()
        let msg = String(cString: nn_strerror(errno))
        self = .Err(errno: errno, msg: msg)
    }
}
