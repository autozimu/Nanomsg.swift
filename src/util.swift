import CNanomsg

// Query the names and values of nanomsg symbols.
public func symbol(index: CInt) -> (CInt, String?) {
    var i: CInt = 0
    let cstr = nn_symbol(index, &i)
    return (i, String(cString: cstr))
}
