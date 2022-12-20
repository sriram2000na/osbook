int main() {
  char *video_address = 0xb8000;
  *(video_address) = 'X';
  return 0;
}
