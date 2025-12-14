import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahaai/core/providers/location_provider.dart';
import 'package:sahaai/features/home/domain/entities/location_entity.dart';

class LocationPickerDialog extends StatelessWidget {
  final Function(LocationEntity?) onLocationSelected;
  final VoidCallback? onFirstTimeFetch;

  const LocationPickerDialog({
    Key? key,
    required this.onLocationSelected,
    this.onFirstTimeFetch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationProvider>(
      builder: (context, provider, child) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.all(20),
            height: 400,
            child: Column(
              children: [
                Text('Choose Location', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                
                ElevatedButton.icon(
                  onPressed: provider.isLoading ? null : () async {
                    await provider.fetchCurrentLocationAndSave();
                      if (provider.locations.isNotEmpty) {
    onLocationSelected(provider.locations.first); 
  } 
                    Navigator.pop(context);
                  },
                  icon: provider.isLoading 
                      ? SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                      : Icon(Icons.my_location),
                  label: Text('Current Location'),
                ),
                
                SizedBox(height: 16),
                
                Expanded(
                  child: provider.locations.isEmpty
                      ? Text('No saved locations')
                      : ListView.builder(
                          itemCount: provider.locations.length,
                          itemBuilder: (context, index) {
                            final location = provider.locations[index];
                            return ListTile(
                              leading: Icon(Icons.location_on),
                              title: Text(location.address),
                              trailing: location.isPrimary 
                                  ? Icon(Icons.star, color: Colors.amber)
                                  : null,
                              onTap: () {
                                onLocationSelected(location);
                                Navigator.pop(context);
                              },
                            );
                          },
                        ),
                ),
                
                TextButton(
                  onPressed: onFirstTimeFetch,
                  child: Text('Set as Primary (First time)'),
                ),
                
                Row(
                  children: [
                    Expanded(child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Cancel'),
                    )),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
