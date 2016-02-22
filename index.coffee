
dgram = require 'dgram'

createPacket = (mac) ->
  buf = new Buffer 6 + 16 * 6
  mac.copy buf, i * 6 for i in [1..16]
  buf.fill 0xff, 0, 6

parseHex = (n) -> parseInt n, 16
isByte   = (b) -> (0x00 <= b <= 0xff)

parseMAC = (str) ->
  mac = (b for s in str.split ':' when isByte (b = parseHex s))
  throw 'Invalid MAC address' unless mac.length is 6
  new Buffer mac

sendWOL = (mac, opts, cb) ->
  if typeof opts is 'function'
    cb = opts
    opts = {}
  else if not opts?
    opts = {}

  packet = createPacket mac

  sock = dgram.createSocket opts.type || 'udp4'
  sock.on 'error', cb
  sock.bind () ->
    sock.setBroadcast true
  port = opts.port || 9
  addr = opts.address || '255.255.255.255'
  sock.send packet, 0, packet.length, port, addr, (err) ->
    sock.close()
    cb err

module.exports = {
  createPacket
  parseMAC
  sendWOL
}
