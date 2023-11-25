enum DeviceType { small, phone, tablet, desktop }

const smallDevices = 320;
const phoneDevices = 600;
const tabletDevices = 1024;

DeviceType getDeviceType(double dimension) {
  if (dimension < smallDevices) {
    return DeviceType.small;
  } else if (dimension < phoneDevices) {
    return DeviceType.phone;
  } else if (dimension < tabletDevices) {
    return DeviceType.tablet;
  }
  return DeviceType.desktop;
}
