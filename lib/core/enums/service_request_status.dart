/// Represents the lifecycle of a service request
/// Backend enum (C#):
/// 1 - Pending
/// 2 - Searching
/// 3 - ExpandingRadius
/// 4 - Accepted
/// 5 - InProgress
/// 6 - Completed
/// 7 - Cancelled
/// 8 - NoWorkersAvailable
enum ServiceRequestStatus {
  pending,
  searching,
  expandingRadius,
  accepted,
  inProgress,
  completed,
  cancelled,
  noWorkersAvailable;

  /// Converts backend integer value to enum
  static
   ServiceRequestStatus fromInt(int value) {
    switch (value) {
      case 1:
        return ServiceRequestStatus.pending;
      case 2:
        return ServiceRequestStatus.searching;
      case 3:
        return ServiceRequestStatus.expandingRadius;
      case 4:
        return ServiceRequestStatus.accepted;
      case 5:
        return ServiceRequestStatus.inProgress;
      case 6:
        return ServiceRequestStatus.completed;
      case 7:
        return ServiceRequestStatus.cancelled;
      case 8:
        return ServiceRequestStatus.noWorkersAvailable;
      default:
        return ServiceRequestStatus.pending;
    }
  }

  /// Converts enum back to backend int (optional but future-proof)
  // int get toInt {
  //   switch (this) {
  //     case ServiceRequestStatus.pending:
  //       return 1;
  //     case ServiceRequestStatus.searching:
  //       return 2;
  //     case ServiceRequestStatus.expandingRadius:
  //       return 3;
  //     case ServiceRequestStatus.accepted:
  //       return 4;
  //     case ServiceRequestStatus.inProgress:
  //       return 5;
  //     case ServiceRequestStatus.completed:
  //       return 6;
  //     case ServiceRequestStatus.cancelled:
  //       return 7;
  //     case ServiceRequestStatus.noWorkersAvailable:
  //       return 8;
        
  //   }
  // }
}
