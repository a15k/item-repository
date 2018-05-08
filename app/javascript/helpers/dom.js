export default function dom(el) {


}


export function read_csrf() {
  const meta = document.querySelector('meta[name=csrf-token]');
  return meta ? meta.getAttribute('content') : '';
}
