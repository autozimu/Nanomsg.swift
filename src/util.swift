import CNanomsg

func strerror(errno: Int) -> String? {
    return String(cString: nn_strerror(CInt(errno)))
}

var error: (Int, String?) {
    let errno = Int(nn_errno())
    let errstr = strerror(errno: errno)
    return (errno, errstr)
}

