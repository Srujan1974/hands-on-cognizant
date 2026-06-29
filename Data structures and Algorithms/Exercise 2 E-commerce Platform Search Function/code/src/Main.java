public class Main {

    public static void main(String[] args) {

        // Unsorted array for Linear Search
        Product[] products = {

                new Product(104, "Laptop", "Electronics"),
                new Product(101, "Mouse", "Electronics"),
                new Product(103, "Keyboard", "Electronics"),
                new Product(105, "Chair", "Furniture"),
                new Product(102, "Notebook", "Stationery")
        };

        // Sorted array for Binary Search
        Product[] sortedProducts = {

                new Product(101, "Mouse", "Electronics"),
                new Product(102, "Notebook", "Stationery"),
                new Product(103, "Keyboard", "Electronics"),
                new Product(104, "Laptop", "Electronics"),
                new Product(105, "Chair", "Furniture")
        };

        int target = 103;

        // ---------------- Linear Search ----------------

        long startLinear = System.nanoTime();

        Product linearResult =
                SearchAlgorithms.linearSearch(products, target);

        long endLinear = System.nanoTime();

        // ---------------- Binary Search ----------------

        long startBinary = System.nanoTime();

        Product binaryResult =
                SearchAlgorithms.binarySearch(sortedProducts, target);

        long endBinary = System.nanoTime();

        // Display Results

        System.out.println("===== Linear Search =====");

        if (linearResult != null)
            System.out.println(linearResult);
        else
            System.out.println("Product Not Found");


        System.out.println("\n===== Binary Search =====");

        if (binaryResult != null)
            System.out.println(binaryResult);
        else
            System.out.println("Product Not Found");


        // ---------------- Analysis ----------------

        long linearTime = endLinear - startLinear;
        long binaryTime = endBinary - startBinary;

        System.out.println("\n===== Time Complexity Analysis =====");

        System.out.println("Linear Search Execution Time : "
                + linearTime + " ns");

        System.out.println("Binary Search Execution Time : "
                + binaryTime + " ns");

        System.out.println("\nTheoretical Time Complexity");

        System.out.println("Linear Search : O(n)");
        System.out.println("Binary Search : O(log n)");

        if (linearTime > binaryTime) {

            System.out.println("\nBinary Search performed faster than Linear Search.");

        } else if (linearTime < binaryTime) {

            System.out.println("\nLinear Search performed faster than Binary Search.");

        } else {

            System.out.println("\nBoth algorithms took approximately the same time.");

        }

        System.out.println("\nConclusion:");
        System.out.println("Binary Search is generally more efficient for large sorted datasets because");
        System.out.println("it searches by repeatedly dividing the array into two halves.");
        System.out.println("Linear Search checks each element one by one, making it slower for large datasets.");
    }
}