package pl.szybkimaksiu.autorynek;

import net.fabricmc.api.ModInitializer;
import org.slf4j.Logger;          // POPRAWA: "slf4j" → "slf4j"
import org.slf4j.LoggerFactory;

public class SzybkiSniperMod implements ModInitializer {  // ZMIENIONE!
    public static final Logger LOGGER = LoggerFactory.getLogger("Szybki-Sniper"); // ZMIENIONE!
    
    @Override
    public void onInitialize() {
        LOGGER.info("Szybki-Sniper 1.0 został załadowany!");  // ZMIENIONE!
    }
}
