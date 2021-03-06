exclude :test_argv0, "needs investigation"
exclude :test_argv0_noarg, "hangs"
exclude :test_aspawn_too_long_path, "out of memory error"
exclude :test_clock_getres_CLOCK_BASED_CLOCK_PROCESS_CPUTIME_ID, "missing process timing functionality"
exclude :test_clock_getres_GETTIMEOFDAY_BASED_CLOCK_REALTIME, "missing process timing functionality"
exclude :test_clock_getres_TIME_BASED_CLOCK_REALTIME, "missing process timing functionality"
exclude :test_clock_gettime_CLOCK_BASED_CLOCK_PROCESS_CPUTIME_ID, "missing process timing functionality"
exclude :test_clock_gettime_GETTIMEOFDAY_BASED_CLOCK_REALTIME, "missing process timing functionality"
exclude :test_clock_gettime_TIME_BASED_CLOCK_REALTIME, "missing process timing functionality"
exclude :test_clock_gettime_unit, "missing process timing functionality"
exclude :test_deadlock_by_signal_at_forking, "uses fork"
exclude :test_exec_noshell, "needs investigation"
exclude :test_exec_wordsplit, "needs investigation"
exclude :test_execopts_chdir, "needs investigation"
exclude :test_execopts_close_others, "needs investigation"
exclude :test_execopts_env, "needs investigation"
exclude :test_execopts_env_popen_string, "needs investigation"
exclude :test_execopts_env_popen_vector, "needs investigation"
exclude :test_execopts_env_single_word, "out of memory error"
exclude :test_execopts_exec, "needs investigation"
exclude :test_execopts_gid, "needs investigation"
exclude :test_execopts_open_chdir, "out of memory error"
exclude :test_execopts_pgroup, "needs investigation"
exclude :test_execopts_popen, "needs investigation"
exclude :test_execopts_preserve_env_on_exec_failure, "needs investigation"
exclude :test_execopts_redirect, "out of memory error"
exclude :test_execopts_redirect_dup2_child, "out of memory error"
exclude :test_execopts_redirect_nonascii_path, "out of memory error"
exclude :test_execopts_redirect_to_out_and_err, "out of memory error"
exclude :test_execopts_uid, "needs investigation"
exclude :test_execopts_umask, "unsupported"
exclude :test_execopts_unsetenv_others, "unsupported"
exclude :test_fallback_to_sh, "needs investigation"
exclude :test_fd_inheritance, "needs investigation"
exclude :test_gid_re_exchangeable_p, "unimplemented"
exclude :test_gid_sid_available?, "unimplemented"
exclude :test_no_curdir, "out of memory error"
exclude :test_popen_wordsplit, "needs investigation"
exclude :test_popen_wordsplit_beginning_and_trailing_spaces, "needs investigation"
exclude :test_process_detach, "uses fork"
exclude :test_pst_inspect, "uses Process::Status allocator"
exclude :test_seteuid_name, "argument coersion error"
exclude :test_sh_exec, "needs investigation"
exclude :test_spawn_noshell, "needs investigation"
exclude :test_spawn_too_long_path, "out of memory error"
exclude :test_spawn_wordsplit, "needs investigation"
exclude :test_status_kill, "needs investigation"
exclude :test_status_quit, "needs investigation"
exclude :test_system_wordsplit, "needs investigation"
exclude :test_uid_re_exchangeable_p, "unimplemented"
exclude :test_uid_sid_available?, "unimplemented"
