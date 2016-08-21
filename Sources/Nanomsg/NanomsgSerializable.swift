public protocol NanomsgSerializable {
    static func deserialize(_ buffer: UnsafeMutableBufferPointer<UInt8>) -> Self
}
