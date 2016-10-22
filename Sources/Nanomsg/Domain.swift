/** SP address families */
public enum Domain: CInt {
    /** Standard full-blown SP socket. */
    case AF_SP = 1

    /** Raw SP socket. */
    case AF_SP_RAW = 2
}
