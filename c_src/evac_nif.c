#include "erl_nif.h"

#include <stdio.h>
#include <signal.h>
#include <unistd.h>

// PID where we will send our SIGINT message
ErlNifPid dest_process;

void signal_handler(int signo)
{
  if (signo == SIGINT)
  {
      ErlNifEnv* env = enif_alloc_env();
      ERL_NIF_TERM message = enif_make_string(env, "SIGINT", ERL_NIF_LATIN1);
      enif_send(NULL, &dest_process, env, message);
      enif_clear_env(env);
  }
}

ERL_NIF_TERM setup(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[])
{
    // Try and register our signal callback
    if(signal(SIGINT, signal_handler) == SIG_ERR)
    {
        enif_make_int(env, 1);
    }

    // Assign the destination pid
    enif_get_local_pid(env, argv[0], &dest_process);

    // Happy status code
    return enif_make_int(env, 0);
}

static ErlNifFunc nif_funcs[] = {
  {"setup", 1, setup}
};

ERL_NIF_INIT(Elixir.Evac, nif_funcs, NULL, NULL, NULL, NULL);