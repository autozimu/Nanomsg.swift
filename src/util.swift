import CNanomsg

var error: (Int, String?) {
    let errno = nn_errno()
    let strerr = nn_strerror(errno)
    return (Int(errno), String.fromCString(strerr))
}
