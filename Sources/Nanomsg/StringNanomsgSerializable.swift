extension String: NanomsgSerializable {

    public static func deserialize(_ buffer: UnsafeMutableBufferPointer<UInt8>) -> String {
        let cstr = buffer.baseAddress!
        return String(cString: cstr)
    }
}
