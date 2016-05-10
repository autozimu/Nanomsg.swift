import CNanomsg

public extension Socket {
    /** Get socket option of type Int. */
    internal func getOpt(_ opt: CInt, level: CInt = NN_SOL_SOCKET) -> CInt {
        var value: CInt = -1
        var size = sizeof(CInt)
        nn_getsockopt(socketid, level, opt, &value, &size)
        return value
    }
    
    /** Get generic socket option of type String. */
    internal func getOptStr(_ opt: CInt, level: CInt = NN_SOL_SOCKET) -> String {
        var sz = 100
        let value = UnsafeMutablePointer<CChar>(allocatingCapacity: sz)
        nn_getsockopt(socketid, level, opt, value, &sz)
        return String(cString: value)
    }

    /** Set socket option of type Int. */
    internal func setOpt(_ opt: CInt, _ newValue: CInt, level: CInt = NN_SOL_SOCKET) {
        var newValue = newValue
        nn_setsockopt(socketid, level, opt, &newValue, sizeof(CInt))
    }
    
    /** Set socket option of String type. */
    internal func setOptStr(_ opt: CInt, _ newValue: String, level: CInt = NN_SOL_SOCKET) {
        let sz = newValue.characters.count + 1
        nn_setsockopt(socketid, level, opt, newValue, sz)
    }

    public var linger: CInt {
        get { return getOpt(NN_LINGER) }
        set { setOpt(NN_LINGER, newValue) }
    }

    public var sndbuf: CInt {
        get { return getOpt(NN_SNDBUF)  }
        set { setOpt(NN_SNDBUF, newValue) }
    }

    public var rcvbuf: CInt {
        get { return getOpt(NN_RCVBUF) }
        set { setOpt(NN_RCVBUF, newValue) }
    }

    public var rcvmaxsize: CInt {
        get { return getOpt(NN_RCVMAXSIZE) }
        set { setOpt(NN_RCVMAXSIZE, newValue) }
    }

    public var sndtimeo: CInt {
        get { return getOpt(NN_SNDTIMEO) }
        set { setOpt(NN_SNDTIMEO, newValue) }
    }

    public var rcvtimeo: CInt {
        get { return getOpt(NN_RCVTIMEO) }
        set { setOpt(NN_RCVTIMEO, newValue) }
    }

    public var reconnect_ivl: CInt {
        get { return getOpt(NN_RECONNECT_IVL) }
        set { setOpt(NN_RECONNECT_IVL, newValue) }
    }

    public var reconnect_ivl_max: CInt {
        get { return getOpt(NN_RECONNECT_IVL_MAX) }
        set { setOpt(NN_RECONNECT_IVL_MAX, newValue) }
    }

    public var sndprio: CInt {
        get { return getOpt(NN_SNDPRIO) }
        set { setOpt(NN_SNDPRIO, newValue) }
    }

    public var rcvprio: CInt {
        get { return getOpt(NN_RCVPRIO) }
        set { setOpt(NN_RCVPRIO, newValue) }
    }

    public var ipv4only: CInt {
        get { return getOpt(NN_IPV4ONLY) }
        set { setOpt(NN_IPV4ONLY, newValue) }
    }

    public var name: String {
        get { return getOptStr(NN_SOCKET_NAME) }
        set { setOptStr(NN_SOCKET_NAME, newValue) }
    }

    // TODO
    // var sndfd

    // TODO
    // var rcvfd
    
    public var req_resend_ivl: CInt {
        get { return getOpt(NN_REQ_RESEND_IVL, level: Proto.REQ.rawValue) }
        set { setOpt(NN_REQ_RESEND_IVL, newValue, level: Proto.REQ.rawValue) }
    }
    
    public var sub_subscribe: String {
        get { return getOptStr(NN_SUB_SUBSCRIBE, level: Proto.SUB.rawValue) }
        set { setOptStr(NN_SUB_SUBSCRIBE, newValue, level: Proto.SUB.rawValue) }
    }
    
    public var sub_unsubscribe: String {
        get { return getOptStr(NN_SUB_UNSUBSCRIBE, level: Proto.SUB.rawValue) }
        set { setOptStr(NN_SUB_UNSUBSCRIBE, newValue, level: Proto.SUB.rawValue) }
    }
    
    public var surveyor_deadline: CInt {
        get { return getOpt(NN_SURVEYOR_DEADLINE, level: Proto.SURVEYOR.rawValue) }
        set { setOpt(NN_SURVEYOR_DEADLINE, newValue, level: Proto.SURVEYOR.rawValue) }
    }
}
