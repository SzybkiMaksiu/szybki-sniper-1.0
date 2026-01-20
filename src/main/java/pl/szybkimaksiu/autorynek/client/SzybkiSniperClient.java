package pl.szybkimaksiu.autorynek.client;

import net.fabricmc.api.ClientModInitializer;

public class SzybkiSniperClient implements ClientModInitializer {
    @Override
    public void onInitializeClient() {
        System.out.println("Szybki-Sniper Client loaded!");
    }
}
