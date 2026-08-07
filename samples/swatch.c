/* Render the baseline dark accents as ANSI swatches with WCAG contrast. */
#include <math.h>
#include <stdio.h>
#include <stdlib.h>

#define SURFACE "#111418"
#define MIN_RATIO 4.5 /* WCAG AA for normal text */

typedef struct {
    const char *name;
    const char *hex;
} swatch;

static const swatch accents[] = {
    {"green", "#A1D39A"},   {"blue", "#AAC7FF"}, {"orange", "#FDB975"},
    {"cyan", "#83D3E3"},    {"magenta", "#EBB5ED"},
    {"yellow", "#D4C871"},  {"red", "#FFB3AC"},
};

static int parse_rgb(const char *hex, unsigned *r, unsigned *g, unsigned *b)
{
    return sscanf(hex, "#%02x%02x%02x", r, g, b) == 3;
}

static double linear(unsigned channel)
{
    double v = channel / 255.0;
    return v <= 0.04045 ? v / 12.92 : pow((v + 0.055) / 1.055, 2.4);
}

static double luminance(unsigned r, unsigned g, unsigned b)
{
    return 0.2126 * linear(r) + 0.7152 * linear(g) + 0.0722 * linear(b);
}

static double contrast(double a, double b)
{
    double hi = a > b ? a : b;
    double lo = a > b ? b : a;
    return (hi + 0.05) / (lo + 0.05);
}

static const char *grade(double ratio)
{
    if (ratio >= 7.0)
        return "AAA";
    if (ratio >= MIN_RATIO)
        return "AA";
    if (ratio >= 3.0)
        return "AA-LARGE";
    return "FAIL";
}

int main(void)
{
    unsigned r, g, b;
    if (!parse_rgb(SURFACE, &r, &g, &b)) {
        fprintf(stderr, "bad surface: %s\n", SURFACE);
        return EXIT_FAILURE;
    }
    double background = luminance(r, g, b);
    for (size_t i = 0; i < sizeof accents / sizeof *accents; i++) {
        if (!parse_rgb(accents[i].hex, &r, &g, &b)) {
            fprintf(stderr, "%s: bad hex %s\n", accents[i].name, accents[i].hex);
            return EXIT_FAILURE;
        }
        double ratio = contrast(luminance(r, g, b), background);
        printf("\x1b[48;2;%u;%u;%um    \x1b[0m %-8s %s  %5.2f:1  %s\n",
               r, g, b, accents[i].name, accents[i].hex, ratio, grade(ratio));
    }
    return EXIT_SUCCESS;
}
