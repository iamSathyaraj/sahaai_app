
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:sahaai/core/providers/location_provider.dart';
import 'package:sahaai/features/home/presentation/pages/location_picker_dialogue.dart';
import 'package:sahaai/features/home/presentation/pages/service_issue_screen.dart';
import 'package:sahaai/features/home/presentation/provider/home_provider.dart';
// import 'package:sahaai/features/home/domain/entities/location_entity.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const Color mainColor = Color(0xFF466765);
  int? selectedIndex;

  // final List<ServiceItem> services = const [
  //   ServiceItem('Electrician', 'assets/electrician.png'),
  //   ServiceItem('Carpenter', 'assets/carpenter.png'),
  //   ServiceItem('Cleaner', 'assets/cleaner.png'),
  //   ServiceItem('Laundry', 'assets/laundry.png'),
  // ];
@override
void initState() {
  super.initState();
  WidgetsBinding.instance.addPostFrameCallback((_) async {
    final locProvider = Provider.of<LocationProvider>(context, listen: false);
    
    print('🏠 HomePage: Permission + GPS setup...');
    
    // 🚀 STEP 1: Permission (popup if needed)
    final status = await Permission.location.status;
    print('🏠 Permission status: $status');
    
    if (!status.isGranted) {
      print('🏠 Showing permission popup...');
      await locProvider.requestPermission();  // 👈 POPUP!
    }
    
    // 🚀 STEP 2: AUTO GPS + Cache (Your REAL goal!)
    print('🏠 AUTO GPS fetch...');
    await locProvider.fetchFirstLocation();  // 👈 GPS + Backend + Cache!
    
    // STEP 3: Final cache load
    await locProvider.loadCachedPrimary();
    print('🏠 Setup COMPLETE!');

    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
await homeProvider.getHomeServices(); 
  });
  
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildLocationHeader(context),
            
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Hai Sathya',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _SearchBar(),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Container(
                height: 110,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Center(
                  child: Text(
                    'Welcome to Sahaai!\nBook services instantly',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 8),

            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
                  child: Column(
                    children: [
                      const Text(
                        'Quick Services',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF466765),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: Consumer<HomeProvider>(
                          builder: (context, homeProvider, child) {
                       if (homeProvider.isLoading) {
                            return const Center(child: CircularProgressIndicator());
                         }   
                          if (homeProvider.error != null) {
      return Center(child: Text('Error: ${homeProvider.error}'));
    }
                                         return  
                                                GridView.builder(
                            itemCount: homeProvider.services.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 16,
                              crossAxisSpacing: 12,
                              childAspectRatio: 0.75,
                            ),
                            itemBuilder: (context, index) {
                              final service = homeProvider.services[index];
                              return ServiceCard(
                                title: service.name,
                                assetPath: service.imageUrl,
                                selected: selectedIndex == index,

                                onTap: () {
                                  setState(() {
                                    selectedIndex = index;
                                  });
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                       ServiceIssueScreen(serviceId: service.id,serviceName: service.name,)
                                      
                                        // serviceId: index + 1,
                                        // serviceName: item.title,
                                      
                                    ),
                                  );
                                },
                              );
                            },
                          );
  }
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationHeader(BuildContext context) {
    return Consumer<LocationProvider>(
      builder: (context, locationProvider, child) {
        return Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(
                Icons.location_on, 
                color: Colors.green[600], 
                size: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Your Location",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      locationProvider.isLoading
                          ? "Getting your location..."
                          : locationProvider.displayAddress,  
                      style: TextStyle(
                        fontSize: 14, 
                        color: Colors.grey[600],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (locationProvider.error != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        locationProvider.error!,
                        style: TextStyle(
                          color: Colors.red[600], 
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (locationProvider.hasPrimaryLocation)  
                IconButton(
                  icon: const Icon(Icons.edit_location_alt),
                  onPressed: locationProvider.isLoading
                      ? null
                      : () => _showLocationPicker(context, locationProvider),
                  tooltip: 'Change Location',
                )
              else
                ElevatedButton.icon(
                  onPressed: locationProvider.isLoading
                      ? null
                      : () async {
                          await locationProvider.fetchFirstLocation();
                        },
                  icon: locationProvider.isLoading
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.location_on, size: 16),
                  label: const Text('Set Location'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[600],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  void _showLocationPicker(BuildContext context, LocationProvider provider) {
    showDialog(
      context: context,
      builder: (context) => LocationPickerDialog(
        onLocationSelected: (location) {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          hintText: 'Search services',
          hintStyle: TextStyle(
            color: Colors.grey[500],
            fontSize: 14,
          ),
          prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
          border: InputBorder.none,
        ),
        onChanged: (value) {
        },
      ),
    );
  }
}

class ServiceItem {
  final String title;
  final String assetPath;

  const ServiceItem(this.title, this.assetPath);
}

class ServiceCard extends StatelessWidget {
  final String title;
  final String assetPath;
  final bool selected;
  final VoidCallback? onTap;

  const ServiceCard({
    super.key,
    required this.title,
    required this.assetPath,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const Color mainColor = Color(0xFF466765);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        decoration: BoxDecoration(
          color: selected ? mainColor.withOpacity(0.10) : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: selected ? Border.all(color: mainColor, width: 1.5) : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Image.asset(
                  assetPath,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.image_not_supported, size: 40, color: Colors.grey);
                  },
                ),
              ),
            ),
            const SizedBox(height: 6),
            Flexible(
              flex: 1,
              child: Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
