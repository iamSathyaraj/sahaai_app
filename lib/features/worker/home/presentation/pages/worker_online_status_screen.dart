import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahaai/features/worker/home/presentation/providers/worker_status_provider.dart';
import 'package:sahaai/features/worker/home/presentation/widgets/swipe_button.dart';

class WorkerStatusScreen extends StatelessWidget {
  const WorkerStatusScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    final mainColor = const Color(0xFF466765);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
    
      appBar: AppBar(
        elevation: 0,
        backgroundColor: mainColor,
 
        actions: [
          Consumer<WorkerStatusProvider>(
            builder: (context, provider, _) {
               final isOnline = provider.isOnline;
               final isLoading = provider.isLoading;

               return Padding(
                 padding: const EdgeInsets.only(right: 12),
                 child: InkWell(
                 borderRadius: BorderRadius.circular(20),
                 onTap: isLoading
                ? null
                : () {
                    if (isOnline) {
                      provider.goOffline();
                    } else {
                      provider.goOnline();
                    }
                  },
               child: Container(
                 padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                 decoration: BoxDecoration(
                  color: isOnline
                    ? const Color(0xFFE8F5E9) 
                    : const Color(0xFFFFEBEE),
                  borderRadius: BorderRadius.circular(20),
                ),
                 child: Row(
                   mainAxisSize: MainAxisSize.min,
                   children: [
                     if (isLoading) ...[
                        const SizedBox(
                           height: 14,
                           width: 14,
                           child: CircularProgressIndicator(
                             strokeWidth: 2,
                           ),
                        )  ,
                     ] else ...[
                       Icon(
                         Icons.circle,
                         size: 10,
                         color: isOnline
                          ? const Color(0xFF2E7D32)
                            : const Color(0xFFB71C1C),
                      ),
                     ],
                    const SizedBox(width: 6),
                    Text(
                      isLoading
                         ? 'Updating'
                        : (isOnline ? 'Online' : 'Offline'),
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: isOnline
                          ? const Color(0xFF2E7D32)
                          : const Color(0xFFB71C1C),
                        ),
                      ),
                   ],
                 ),
               ),
             ),
           );
         },
       ),
     ],
    ),

    body: Consumer<WorkerStatusProvider>(
        builder: (context, provider, _) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  color: mainColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Row(
                    children: [
                      Icon(
                        provider.isOnline ? Icons.check_circle : Icons.cancel,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          provider.isOnline
                              ? 'You are currently ONLINE and can receive job requests.'
                              : 'You are currently OFFLINE. Swipe to go online and start receiving jobs.',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Your status',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Text(
                  provider.isOnline
                      ? 'Customers nearby can see you and send requests.'
                      : 'Customers will not see you while you are offline.',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                  ),
                ),
                if (provider.errorMessage != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    provider.errorMessage!,
                    style: const TextStyle(color: Colors.red, fontSize: 13),
                  ),
                ],
                const SizedBox(height: 24),

                const Spacer(),
                const AdvancedSwipeOnlineButton(),
                const SizedBox(height: 16),
                Text(
                  provider.isOnline
                      ? 'Waiting for new job requests…'
                      : 'Go online to start receiving job requests.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
