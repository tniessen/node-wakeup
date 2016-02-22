
{ parseMAC, sendWOL } = require './'
{ createParser }      = require 'args.js'

parser = createParser [
    id: 'help'
    isSwitch: true
    flags: [ 'h', 'help' ]
    special: true
    help: 'Show this message and exit'
  ,
    id: 'address'
    name: 'broadcast address'
    flags: [ 'b', 'broadcast' ]
    defaultValue: '255.255.255.255'
    help: 'Broadcast address'
  ,
    id: 'mac'
    name: 'MAC address'
    validator: (arg) -> parseMAC arg
    required: true
    help: 'Target host'
]

try
  options = parser.parse()
catch err
  console.error err.message
  process.exit 1

if options.help
  console.log 'wakeup ' + parser.help()
  return

sendWOL options.mac, { address: options.address }, (err) ->
  if err
    console.error err
    process.exit 2
