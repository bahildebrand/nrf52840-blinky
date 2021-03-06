/**
 * @file vectors.c
 * @author Blake Hildebrand (baugusthildebrand@gmail.com)
 * @brief Exception vectors for cortex-m MCUs
 */

#include <stdint.h>
#include <startup.h>

extern uint32_t _stack_end;

int main(void);
static void reset_handler(void);
static void nmi_handler(void);
static void hardfault_handler(void);
static void mem_management_fault_handler(void);
static void bus_fault_handler(void);
static void usage_fault_handler(void);
static void sv_call_handler(void);
static void pend_sv_handler(void);
static void systick_handler(void);

struct vector_table {
        void *stack_val;
        void *reset;
        void *nmi;
        void *hard_fault;
        void *mem_management_fault;
        void *bus_fault;
        void *usage_fault;
        void *reservd[4];
        void *sv_call;
        void *pend_sv;
        void *systick;
};

__attribute__ ((section(".vecs")))
struct vector_table vec_table = {
        .stack_val = (void*) &_stack_end,
        .reset = (void*) reset_handler,
        .nmi = (void*) nmi_handler,
        .hard_fault = (void*) hardfault_handler,
        .mem_management_fault = (void*) mem_management_fault_handler,
        .bus_fault = (void*) bus_fault_handler,
        .usage_fault = (void*) usage_fault_handler,
        .sv_call = (void*) sv_call_handler,
        .pend_sv = (void*) pend_sv_handler,
        .systick = (void*) systick_handler,
};

static void reset_handler(void)
{
        init_mem();

        main();
}

static void nmi_handler(void)
{
        while(1) {;}
}

static void hardfault_handler(void)
{
        while(1) {;}
}

static void mem_management_fault_handler(void)
{
        while(1) {;}
}

static void bus_fault_handler(void)
{
        while(1) {;}
}

static void usage_fault_handler(void)
{
        while(1) {;}
}

static void sv_call_handler(void)
{

}

static void pend_sv_handler(void)
{

}

static void systick_handler(void)
{

}