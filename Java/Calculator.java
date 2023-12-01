import java.util.Scanner;

public class Calculator {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        System.out.println("Witaj w prostym kalkulatorze!");

        System.out.print("Podaj pierwszą liczbę: ");
        double liczba1 = scanner.nextDouble();

        System.out.print("Podaj drugą liczbę: ");
        double liczba2 = scanner.nextDouble();

        System.out.println("Wybierz rodzaj operacji:");
        System.out.println("1. Dodawanie (+)");
        System.out.println("2. Odejmowanie (-)");
        System.out.println("3. Mnożenie (*)");
        System.out.println("4. Dzielenie (/)");
        System.out.print("Twój wybór: ");

        int operacja = scanner.nextInt();

        double wynik = 0;

        switch (operacja) {
            case 1:
                wynik = liczba1 + liczba2;
                break;
            case 2:
                wynik = liczba1 - liczba2;
                break;
            case 3:
                wynik = liczba1 * liczba2;
                break;
            case 4:
                if (liczba2 != 0) {
                    wynik = liczba1 / liczba2;
                } else {
                    System.out.println("Nie można dzielić przez zero!");
                    return;
                }
                break;
            default:
                System.out.println("Wybrano niepoprawną operację.");
                return;
        }

        System.out.println("Wynik: " + wynik);
        scanner.close();
    }
}
