/** Transport machanism */
enum Transport: CInt {
    // inproc.h
    case INPROC = -1

    // ipc.h
    case IPC = -2

    // tcp.h
    case TCP = -3

    // ws.h
    case WS = -4
}
