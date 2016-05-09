public enum Proto: CInt {
    // bus.h
    case BUS = 112

    // inproc.h
    case INPROC = -1

    // pair.h
    case PAIR = 16

    // pipeline.h
    case PUSH = 80
    case PULL = 81

    // pubsub.h
    case PUB = 32
    case SUB = 33

    // reqrep.h
    case REQ = 48
    case REP = 49

    // survey.h
    case SURVEYOR = 98
    case RESPONDENT = 99

    // tcp.h
    case TCP = -3
    case TCP_NODELAY = 1

    // tcpmux.h
    case TCPMUX = -5
    // not unique raw value?
    // case TCPMUX_NODELAY = 1

    // ws.h
    case WS = -4
}
