#include <3ds.h>
#include <stdio.h>
#include "miniz.h"

int main() {
    gfxInitDefault();
    consoleInit(GFX_TOP, NULL);

    printf("Iniciando loader ZIP...\n");

    mz_zip_archive zip;
    memset(&zip, 0, sizeof(zip));

    if (!mz_zip_reader_init_file(&zip, "sdmc:/game.zip", 0)) {
        printf("Erro ao abrir ZIP\n");
    } else {
        int count = mz_zip_reader_get_num_files(&zip);
        printf("Arquivos no ZIP: %d\n", count);

        mz_zip_reader_end(&zip);
    }

    while (aptMainLoop()) {
        hidScanInput();
        if (hidKeysDown() & KEY_START) break;

        gfxSwapBuffers();
        gspWaitForVBlank();
    }

    gfxExit();
    return 0;
}
