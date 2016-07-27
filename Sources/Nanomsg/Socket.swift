import CNanomsg

/** SP socket */
public class Socket {
    let domain: Domain
    let proto: Proto
    var socketid: CInt = -1

    /**
     Create an SP socket.

     - parameters:
         - domain: domain of the socket.
         - proto: type of the socket.
     */
    public init(domain: Domain, proto: Proto) throws {
        self.domain = domain
        self.proto = proto

        socketid = nn_socket(domain.rawValue, proto.rawValue)
        if socketid < 0 {
            throw NanomsgError()
        }
    }

    /**
     Create an SP socket.

     - parameter proto: type of the socket.
     */
    public convenience init(_ proto: Proto) throws {
        try self.init(domain: .AF_SP, proto: proto)
    }

    deinit {
        do {
            try close()
        } catch NanomsgError.Err(let errno, let msg) {
            print(errno, msg)
        } catch {
            print("Unknown error occured")
        }
    }

    /**
     Close an SP Socket.
     */
    public func close() throws {
        let ret = nn_close(socketid)
        if ret < 0 {
            throw NanomsgError()
        }
    }

    /**
     Add a local endpoint to the socket.

     - parameter addr: address to bind to.
     - returns: endpoint id.
     */
    public func bind(_ addr: String) throws -> Int {
        var eid: CInt = -1
        addr.withCString { caddr in
            eid = nn_bind(socketid, caddr)
        }
        if eid < 0 {
            throw NanomsgError()
        }
        return Int(eid)
    }

    /**
     Add a remote endpoint to the socket.

     - parameter addr: address to connect to.
     - returns: endpoint id.
     */
    public func connect(_ addr: String) throws -> Int {
        var eid: CInt = -1
        addr.withCString { caddr in
            eid = nn_connect(socketid, caddr)
        }
        if eid < 0 {
            throw NanomsgError()
        }
        return Int(eid)
    }

    /**
     Remove an endpoint from the socket.

     - parameter eid: ID of the endpoint to remove.
     */
    public func shutdown(eid: CInt) throws {
        let ret = nn_shutdown(socketid, eid)
        if ret < 0 {
            throw NanomsgError()
        }
    }

    /**
     Send a message.

     - parameters:
         - msg: content to send.
         - flags: operation flags.
     - returns: number of bytes sent.
     */
    public func send(_ msg: [UInt8], flags: Flags = .None) throws -> Int {
        let sz_msg = msg.count
        var nSent: CInt = 0

        nSent = nn_send(socketid, msg, sz_msg, flags.rawValue)
        if nSent < 0 {
            throw NanomsgError()
        }

        return Int(nSent)
    }

    /**
     Send a string.

     - parameters:
         - msg: string to send.
         - flags: operation flags.
     - returns: number of bytes sent.
     */
    public func send(_ msg: String, flags: Flags = .None) throws -> Int {
        let sz_msg = msg.characters.count + 1
        var nSent : CInt = 0

        nSent = nn_send(socketid, msg, sz_msg, flags.rawValue)
        if nSent < 0 {
            throw NanomsgError()
        }

        return Int(nSent)
    }

    /**
     Receive a message.

     - parameter flags: operation flags.
     - returns: received content.
     */
    public func recv(flags: Flags = .None) throws -> UnsafeMutableBufferPointer<UInt8> {
        let p = UnsafeMutablePointer<UInt8>(allocatingCapacity: 1)
        let pp = UnsafeMutablePointer<UnsafeMutablePointer<UInt8>>(allocatingCapacity: 1)
        pp.pointee = p;
        let nRecv = nn_recv(socketid, p, NN_MSG, flags.rawValue)
        if nRecv < 0 {
            throw NanomsgError()
        }

        return UnsafeMutableBufferPointer(start: p, count: Int(nRecv))
    }

    /**
     Receive a string.

     - parameter flags: operation flags.
     - returns: received string.
     */
    public func recvstr(flags: Flags = .None) throws -> String? {
        if let cstr = try recv(flags: flags).baseAddress {
            return String(cString: UnsafePointer<CChar>(cstr))
        } else {
            return nil
        }
    }

    // Fine-grained alternative to send.
    func sendmsg() {
        // TODO
    }

    // Find-grained alternative to recv.
    func recvmsg() {
        // TODO
    }

    /**
     Start a device.

     - parameter anotherSock: another socket.
     */
    public func device(anotherSock: Socket) throws {
        let ret = nn_device(socketid, anotherSock.socketid)
        if ret < 0 {
            throw NanomsgError()
        }
    }

    /**
     Notify all sockets about process termination.
     */
    public func term() {
        nn_term()
    }
}
