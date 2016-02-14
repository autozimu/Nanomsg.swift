#include <nanomsg/nn.h>

#include <nanomsg/bus.h>
#undef NN_BUS
#define NN_BUS 112

#include <nanomsg/inproc.h>

#include <nanomsg/ipc.h>

#include <nanomsg/pair.h>
#undef NN_PAIR
#define NN_PAIR 16

#include <nanomsg/pipeline.h>
#undef NN_PUSH
#define NN_PUSH 80
#undef NN_PULL
#define NN_PULL 81

#include <nanomsg/pubsub.h>
#undef NN_PUB
#define NN_PUB 32
#undef NN_SUB
#define NN_SUB 33

#include <nanomsg/reqrep.h>
#undef NN_REQ
#define NN_REQ 48
#undef NN_REP
#define NN_REP 49

#include <nanomsg/survey.h>
#undef NN_SURVEYOR
#define NN_SURVEYOR 98
#undef NN_RESPODENT
#define NN_RESPODENT 99

#include <nanomsg/tcp.h>

#include <nanomsg/tcpmux.h>

#include <nanomsg/ws.h>

static char* nn_recv_wrap(int sock, int flags) {
    char* buf = NULL;
    int bytes = nn_recv(sock, &buf, NN_MSG, flags);
    return buf;
}
