import CNanomsg

// Retrieve the current error.
var errno: CInt {
    return nn_errno()
}

// Convert an error number into human-readable string.
func strerror(errno: CInt) -> String? {
    return String(cString: nn_strerror(errno))
}

// Query the names and values of nanomsg symbols.
func symbol(index: CInt) -> (CInt, String?) {
    var i: CInt = 0
    let cstr = nn_symbol(index, &i)
    return (i, String(cString: cstr))
}
