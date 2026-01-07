import 'package:flutter/material.dart';
import 'package:project/theme/theme.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});
  // Data List untuk Dropdown
  final List<String> listJenisItem = const ["Spare Parts", "Aksesoris", "Oli"];
  final List<String> listJenisKendaraan = const ["Motor", "Mobil"];
  final List<String> listModel = const ["Satria FU", "NEX II", "GSX-R150"];

  // State Manager menggunakan ValueNotifier agar bisa berubah di StatelessWidget
  static final ValueNotifier<String?> selectedJenisItem = ValueNotifier(
    "Spare Parts",
  );
  static final ValueNotifier<String?> selectedJenisKendaraan = ValueNotifier(
    "Motor",
  );
  static final ValueNotifier<String?> selectedModel = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(left: 200, top: 30),
            child: Row(
              children: [
                Text(
                  "Home ",
                  style: blueTextStyle.copyWith(fontWeight: medium),
                ),
                Text(
                  "/ Suzuki Spare Parts",
                  style: blackTextStyle.copyWith(fontWeight: semiBold),
                ),
              ],
            ),
          ),
          SizedBox(height: 40),
          Text(
            'Suzuki Spare Part',
            style: blackTextStyle.copyWith(fontWeight: bold, fontSize: 32),
          ),
          SizedBox(height: 20),

          Text(
            "Suku cadang yang dapat dikonsumsi berkisar dari filter oli hingga filter udara, bantalan rem, dan oli / bahan kimia. Suzuki merekomendasikan suku cadang asli.\nMereka dirancang untuk Suzuki dan sepenuhnya diuji untuk memaksimalkan kinerja dan masa pakai. ",
            textAlign: TextAlign.center,
            style: blackTextStyle.copyWith(fontWeight: semiBold),
          ),
          SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildDropdownField(
                label: "Jenis Item",
                notifier: selectedJenisItem,
                items: listJenisItem,
              ),
              const SizedBox(width: 12),
              _buildDropdownField(
                label: "Jenis Kendaraan",
                notifier: selectedJenisKendaraan,
                items: listJenisKendaraan,
              ),
              const SizedBox(width: 12),
              _buildDropdownField(
                label: "Model Kendaraan",
                notifier: selectedModel,
                items: listModel,
              ),
            ],
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildDropdownField(
                label: "Jenis Item",
                notifier: selectedJenisItem,
                items: listJenisItem,
              ),
              const SizedBox(width: 12),
              _buildDropdownField(
                label: "Jenis Kendaraan",
                notifier: selectedJenisKendaraan,
                items: listJenisKendaraan,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _buildDropdownField({
  required String label,
  required ValueNotifier<String?> notifier,
  required List<String> items,
}) {
  return Container(
    width: 300,
    height: 90,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 5,
          offset: const Offset(0, 2),
        ),
      ],
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 11)),
        ValueListenableBuilder<String?>(
          valueListenable: notifier,
          builder: (context, value, child) {
            return DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: value,
                isExpanded: true,
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.red,
                  size: 20,
                ),
                items: items
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(
                          e,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (val) => notifier.value = val,
              ),
            );
          },
        ),
      ],
    ),
  );
}
