import CNanomsg

public extension Socket {
    var errno: CInt {
        return nn_errno()
    }

    var strerror: String {
        return strerror(errno)
    }

    func strerror(_ errno: CInt) -> String {
        return String(cString: nn_strerror(errno))
    }
}
