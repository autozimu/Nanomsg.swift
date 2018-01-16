import CNanomsg

public extension Socket {

    /** Get socket option of type Int. */
    func getOpt(_ opt: CInt, level: CInt = NN_SOL_SOCKET) -> CInt {
        var value: CInt = -1
        var size = MemoryLayout<CInt>.size
        let ret = nn_getsockopt(socketid, level, opt, &value, &size)
        if ret < 0 {
            print("Error occured while getting option (level: \(level), opt: \(opt)): \(error)")
        }
        return value
    }

    /** Get generic socket option of type String. */
    func getOptStr(_ opt: CInt, level: CInt = NN_SOL_SOCKET) -> String {
        var sz = 100
        let value = UnsafeMutablePointer<CChar>.allocate(capacity: sz)
        let ret = nn_getsockopt(socketid, level, opt, value, &sz)
        if ret < 0 {
            print("Error occured while getting option (level: \(level), opt: \(opt)): \(error)")
        }
        return String(cString: value)
    }

    /** Set socket option of type Int. */
    func setOpt(_ opt: CInt, _ newValue: CInt, level: CInt = NN_SOL_SOCKET) {
        var newValue = newValue
        let ret = nn_setsockopt(socketid, level, opt, &newValue, MemoryLayout<CInt>.size)
        if ret < 0 {
            print("Error occured while setting option (level: \(level), opt: \(opt)): \(error)")
        }
    }

    /** Set socket option of String type. */
    func setOptStr(_ opt: CInt, _ newValue: String, level: CInt = NN_SOL_SOCKET) {
        let sz = newValue.count
        let ret = nn_setsockopt(socketid, level, opt, newValue, sz)
        if ret < 0 {
            print("Error occured while setting option (level: \(level), opt: \(opt)): \(error)")
        }
    }

    /**
     How long the socket should try to send pending outbound messages after
     `nn_close()` have been called, in milliseconds. Negative value means
     infinite linger. Default value is 1000 (1 second).
     */
    public var linger: CInt {
        get { return getOpt(NN_LINGER) }
        set { setOpt(NN_LINGER, newValue) }
    }

    /**
     Size of the send buffer, in bytes. Default value is 128kB.
     */
    public var sndbuf: CInt {
        get { return getOpt(NN_SNDBUF) }
        set { setOpt(NN_SNDBUF, newValue) }
    }

    /**
     Size of the receive buffer, in bytes. Default value is 128kB.
     */
    public var rcvbuf: CInt {
        get { return getOpt(NN_RCVBUF) }
        set { setOpt(NN_RCVBUF, newValue) }
    }

    /**
     Maximum message size that can be received, in bytes. Negative values means
     taht the received size is limited only by available addressable memory.
     Default is 1024kB.
     */
    public var rcvmaxsize: CInt {
        get { return getOpt(NN_RCVMAXSIZE) }
        set { setOpt(NN_RCVMAXSIZE, newValue) }
    }

    /**
     The timeout for send operation on the socket, in milliseconds. If message
     cannot be received within the specified timeout, `EAGAIN` error is
     returned. Negative value means infinite timeout. Default value is -1.
     */
    public var sndtimeo: CInt {
        get { return getOpt(NN_SNDTIMEO) }
        set { setOpt(NN_SNDTIMEO, newValue) }
    }

    /**
     The timeout for recv operation on the socket, in milliseconds. If message
     cannot be received within the specified timeout, `EAGAIN` error is
     returned. Negative value means infinite timeout. Default value is -1.
     */
    public var rcvtimeo: CInt {
        get { return getOpt(NN_RCVTIMEO) }
        set { setOpt(NN_RCVTIMEO, newValue) }
    }

    /**
     For connection-based transports such as TCP, this option specifies how
     long to wait, in milliseconds, when connection is broken before trying to
     re-establish it. Note that actual reconnect interval may be randomised to
     some extent to prevent severe reconnection storms. Default value is 100
     (0.1 second).
     */
    public var reconnect_ivl: CInt {
        get { return getOpt(NN_RECONNECT_IVL) }
        set { setOpt(NN_RECONNECT_IVL, newValue) }
    }

    /**
     This option is to be used only in addition to `reconnect_ivl` option. It
     specifies maximum reconneciton interval. On each reconnect attempt, the
     previous interval is doubled until `reconnect_ivl_max` is reached. Value
     of zero means that no exponential blockoff is performed and reconnect
     interval is based only on `reconnect_ivl`. If `reconnect_ivl_max` is less
     than `reconnect_ivl`, it is ignored. Default value is 0.
     */
    public var reconnect_ivl_max: CInt {
        get { return getOpt(NN_RECONNECT_IVL_MAX) }
        set { setOpt(NN_RECONNECT_IVL_MAX, newValue) }
    }

    /**
     Sets outbound priority for endpoints subsequently added to the socket.
     This option has no effect on socket types taht send messages to all the
     peers. However, if the socket type sends each message to a single peer (or
     a limited set of peers), peers with high priority take precedence over
     peers with low priority. Highest priority is 1, lowest priority is 16.
     Default priority is 8.
     */
    public var sndprio: CInt {
        get { return getOpt(NN_SNDPRIO) }
        set { setOpt(NN_SNDPRIO, newValue) }
    }

    /**
     Sets inbound priority for endpoints subsequently added to the socket. This
     option has no effect on socket types that are not able to receive
     messages. When receiving a message, messages from peers with higher
     priority are received before message from peer with lower priority.
     Highest priority is 1, lowest priority is 16. Default value is 8.
     */
    public var rcvprio: CInt {
        get { return getOpt(NN_RCVPRIO) }
        set { setOpt(NN_RCVPRIO, newValue) }
    }

    /**
     If set to `true`, only IPv4 addresses are used. If set to `false`, both
     IPv4 and IPv6 addresses are used. Default value is `true`.
     */
    public var ipv4only: Bool {
        get { return getOpt(NN_IPV4ONLY) == 1 }
        set { setOpt(NN_IPV4ONLY, newValue == true ? 1 : 0) }
    }

    /**
     Socket name for error reporting and statistics. Default value is
     "socket.N" where N is socket integer.
     */
    public var name: String {
        get { return getOptStr(NN_SOCKET_NAME) }
        set { setOptStr(NN_SOCKET_NAME, newValue) }
    }

    // TODO: 
    // var sndfd

    // TODO: 
    // var rcvfd

    // Specific protocol options.

    /**
     This option is defined on the full REQ socket. If reply is received in
     specified amount of milliseconds, the request will be automatically
     resent. Default value is 60000 (1 minute).
     */
    public var req_resend_ivl: CInt {
        get { return getOpt(NN_REQ_RESEND_IVL, level: Proto.REQ.rawValue) }
        set { setOpt(NN_REQ_RESEND_IVL, newValue, level: Proto.REQ.rawValue) }
    }

    /**
     Defined on full SUB socket. Subscribes fro a particular topic. A single
     `SUB` socket can handle multiple subscriptions.
     */
    public var sub_subscribe: String {
        get { return getOptStr(NN_SUB_SUBSCRIBE, level: Proto.SUB.rawValue) }
        set { setOptStr(NN_SUB_SUBSCRIBE, newValue, level: Proto.SUB.rawValue) }
    }

    /**
     Defined on full SUB socket. Unsubscribe from a particular topic.
     */
    public var sub_unsubscribe: String {
        get { return getOptStr(NN_SUB_UNSUBSCRIBE, level: Proto.SUB.rawValue) }
        set { setOptStr(NN_SUB_UNSUBSCRIBE, newValue, level: Proto.SUB.rawValue) }
    }

    /**
     Specifies how long to wait for responses to the survey. Once the deadline
     expires, receive function will return `ETIMEOUT` error and all subsequent
     response to the survey will be silently dropped. The deadline is measured
     in milliseconds. Default value is 1000 (1 second).
     */
    public var surveyor_deadline: CInt {
        get { return getOpt(NN_SURVEYOR_DEADLINE, level: Proto.SURVEYOR.rawValue) }
        set { setOpt(NN_SURVEYOR_DEADLINE, newValue, level: Proto.SURVEYOR.rawValue) }
    }

    // Specific transport options.

    /**
     This option, when set to `true`, disables Nagle's algorithm. It also
     disables delaying of TCP acknowledgements. Using this option improves
     latency at the expense of throughput. Default value is `false`.
     */
    public var tcp_nodelay: Bool {
        get { return getOpt(NN_TCP_NODELAY, level: Transport.TCP.rawValue) == 1 }
        set { setOpt(NN_TCP_NODELAY, newValue == true ? 1 : 0, level: Transport.TCP.rawValue) }
    }

    /**
     This option may be set to `WSMsgType.Text` or `WSMsgType.Binary`. The
     value of this determines whether data messages are sent as WebSocket text
     frames, or binary frames, per RFC 6455. Text frames should contain only
     valid UTF-8 text in their payload, or they will be rejected. Binary frames
     may contain any data. Not all WebSocket implementation support binary
     frames. The default is to send binary frames.

     This option may also be specified as control data when sending a message
     with `sendmsg()`.
     */
    public var ws_msg_type: WSMsgType {
        get { return WSMsgType(rawValue: getOpt(NN_WS_MSG_TYPE, level: Transport.WS.rawValue))! }
        set { setOpt(NN_WS_MSG_TYPE, newValue.rawValue, level: Transport.WS.rawValue) }
    }
}
