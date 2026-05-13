import 'package:flutter/material.dart';
import 'package:magang_yusuf/api_yusuf.dart';

class SwipeDeleteItem extends StatelessWidget {
  final Map<String, dynamic> item;
  final VoidCallback onTap;
  final Future<void> Function() onRefresh;

  const SwipeDeleteItem({
    super.key,
    required this.item,
    required this.onTap,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(item['id'].toString()),
      direction: DismissDirection.endToStart,

      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 20),
        color: Colors.red,
        child: Icon(Icons.delete, color: Colors.white),
      ),

      confirmDismiss: (direction) async {
        final confirm = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Hapus Data"),
            content: Text("Yakin mau hapus data ini?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text("Batal"),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text("Hapus"),
              ),
            ],
          ),
        );

        if (confirm == true) {
          final id = int.parse(item['id'].toString());
          bool success = await ApiYusuf.deleteData(id);

          if (success) {
            await onRefresh();

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Data berhasil dihapus")),
            );

            return true; 
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Gagal menghapus data")),
            );

            return false; 
          }
        }

        return false;
      },

      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.only(bottom: 10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 4)
            ],
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  item['file'],
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.broken_image, size: 50);
                  },
                ),
              ),
              SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['nama'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(item['tgl_ins']),
                  ],
                ),
              ),

              Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}