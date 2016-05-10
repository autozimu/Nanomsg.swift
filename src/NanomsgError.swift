import CNanomsg

var error: (CInt, String) {
    let errno = nn_errno()
    let msg = String(cString: nn_strerror(errno))
    return (errno, msg)
}

public enum NanomsgError: ErrorProtocol {
    case Err(errno: CInt, msg: String)

    init() {
        let (errno, msg) = error
        self = .Err(errno: errno, msg: msg)
    }
}
