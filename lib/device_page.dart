import 'dart:convert';
import 'package:bluetooth_2/features/bluetooth/presentation/providers/ble_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DevicePage extends ConsumerStatefulWidget {
  const DevicePage({super.key});

  @override
  ConsumerState<DevicePage> createState() => _DevicePageState();
}

class _DevicePageState extends ConsumerState<DevicePage> {
  final TextEditingController _textController = TextEditingController();
  final List<String> _receivedMessages = [];

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final device = ref.watch(selectedDeviceProvider);
    final notificationsStream = ref.watch(characteristicNotificationsProvider);

    // Слушаем уведомления
    ref.listen(characteristicNotificationsProvider, (previous, next) {
      next.whenData((value) {
        if (value.isNotEmpty) {
          setState(() {
            _receivedMessages.add(utf8.decode(value));
          });
        }
      });
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          device?.advName.isNotEmpty == true
              ? device!.advName
              : "Устройство",
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.lightBlue,
      ),
      body: Column(
        children: [
          // Отображение текущего значения характеристики
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.blue.shade50,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Характеристика уведомления:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                notificationsStream.when(
                  data: (value) {
                    String displayValue = value.isEmpty
                        ? "Нет данных"
                        : utf8.decode(value);
                    return Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Icon(Icons.bluetooth, color: Colors.blue),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                displayValue,
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  loading: () => const CircularProgressIndicator(),
                  error: (_, __) => const Text("Ошибка получения данных"),
                ),
              ],
            ),
          ),
          
          // Заголовок истории сообщений
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const Text(
                  "История сообщений:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const Spacer(),
                Text("${_receivedMessages.length} сообщений", 
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          
          // Область полученных сообщений
          Expanded(
            child: _receivedMessages.isEmpty
                ? Center(
                    child: Text(
                      "Нет полученных сообщений",
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _receivedMessages.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(_receivedMessages[index]),
                        ),
                      );
                    },
                  ),
          ),
          
          // Панель отправки сообщений
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      hintText: "Сообщение",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: _sendMessage,
                  icon: const Icon(Icons.send),
                  color: Colors.blue,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _sendMessage() async {
    if (_textController.text.isEmpty) return;
    
    final message = _textController.text;
    final data = utf8.encode("$message\n");
    
    await ref.read(writeCharacteristicProvider.notifier).writeData(data);
    
    _textController.clear();
  }
}