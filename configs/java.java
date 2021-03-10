class Main {
  private static void printf(String fmt, Object... args) {
    System.out.print(String.format(fmt, args));
  }
  
  public static void main(String[] argv) {
    var name = "World";
    printf("Hello %s!\n", name);
  }
}

