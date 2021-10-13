import 'package:udp/udp.dart';

class UDPSocket {
  int _port;

  UDPSocket(this._port);

  int getPort() => this._port;

  findMachine() async {
    var sender = await UDP.bind(Endpoint.any(port: Port(65000)));

    await sender.send(
        'M-SEARCH'.codeUnits, Endpoint.broadcast(port: Port(this._port)));

    var ret = '';
    await sender.listen((datagram) {
      var message = String.fromCharCodes(datagram.data);
      ret = message;
    }, timeout: Duration(seconds: 1));

    String name = ret.split(';')[0];
    String ip = ret.split(';')[1];
    int machinePort = int.parse(ret.split(';')[2]);

    return [name, ip, machinePort];
  }
}
