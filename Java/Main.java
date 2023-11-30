import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.Stream; // Import the Stream class



public class Main {
    public static void main(String[] args) {
        Wall wall = new Wall();  // Create an instance of the Wall class
        // Perform testing or demonstration of the Wall class here
    }
}

interface Structure {
    Optional<Block> findBlockByColor(String color);
    List<Block> findBlocksByMaterial(String material);
    int count();
}

interface Block {
    String getColor();
    String getMaterial();
}

interface CompositeBlock extends Block {
    List<Block> getBlocks();
}

class Wall implements Structure {
    private List<Block> blocks;

    @Override
    public Optional<Block> findBlockByColor(String color) {
        return blocks.stream()
                .filter(block -> block.getColor().equals(color))
                .findFirst();
    }

    @Override
    public List<Block> findBlocksByMaterial(String material) {
        return blocks.stream()
                .filter(block -> block.getMaterial().equals(material))
                .collect(Collectors.toList());
    }

    @Override
    public int count() {
        return blocks.size();
    }

    // Additional method to handle CompositeBlock
    public List<Block> getAllBlocks() {
        List<Block> allBlocks = blocks.stream()
                .flatMap(block -> {
                    if (block instanceof CompositeBlock) {
                        return ((CompositeBlock) block).getBlocks().stream();
                    } else {
                        return Stream.of(block);
                    }
                })
                .collect(Collectors.toList());

        return allBlocks;
    }
}
