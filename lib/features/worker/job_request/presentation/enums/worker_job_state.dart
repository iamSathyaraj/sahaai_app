enum WorkerJobState {
  waiting,                   // online idle
  incoming,                  // received job
  waitingUserConfirmation,   // accepted, waiting
  assigned,                  // user selected this worker 
  missed,               // user selected other worker 
  active,                    // worker started job
}