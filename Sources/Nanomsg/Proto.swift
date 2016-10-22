/** Scalability protocols */
public enum Proto: CInt {
    // pair.h
    /** One-to-one protocol. */
    case PAIR = 16

    // reqrep.h
    /** Request/reply protocol. This socket type is used to send requests and receive replies. */
    case REQ = 48
    /** Request/reply protocol. This socket type is used to receive requests and sends replies. */
    case REP = 49

    // pubsub.h
    /** Publish/Subscribe protocol. This socket type is used to distribute messages to multiple destinations. */
    case PUB = 32
    /** Publish/Subscribe protocol. This socket type is used to receives messages from the publisher. */
    case SUB = 33

    // survey.h
    /** Survey protocol. This socket type is used to send the survrey. */
    case SURVEYOR = 98
    /** Survey protocol. This socket type is used to respond to the survey. */
    case RESPONDENT = 99

    // pipeline.h
    /** Pipeline protocol. This socket type is used to send message to a cluster of load-balanced nodes. */
    case PUSH = 80
    /** Pipeline protocol. This socket type is used to receive a message from a cluster of nodes. */
    case PULL = 81

    // bus.h
    /** Message bus protocol. */
    case BUS = 112
}
