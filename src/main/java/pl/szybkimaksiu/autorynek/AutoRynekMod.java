package pl.szybkimaksiu.autorynek;

import net.fabricmc.api.ModInitializer;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class AutoRynekMod implements ModInitializer {
    public static final Logger LOGGER = LoggerFactory.getLogger("AutoRynek");
    
    @Override
    public void onInitialize() {
        LOGGER.info("AutoRynek został załadowany!");
    }
}
