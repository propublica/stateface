#include "src/shape.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <iostream>
#include <unistd.h>

typedef struct {
  char *shpfile;
  char *proj;
  double simplification;
  char *name_field;
  char *filter;
} opt_t;


void help(){
  fprintf (stderr,
    "font-for-us generates eps files for StateFace."
    "\nusage: font-for-us <shpfile> -p <proj> -s <simplification> -n <name-field> -f <filter>\n"
    "\n"
    "Options:\n"
    "  -p projection as in an OGR readable format. (required)\n"
    "  -s simplification to apply to each shape. (required)\n"
    "  -n name field of shapefile to build output filename from. (required)\n"
    "  -f filter value to filter the shapefile on, i.e. AK to only output Alaska. (optional)\n\n"
  );
  exit(1);
}

void get_options(opt_t *opt, int argc, char **argv){
  int c, i;

  memset(opt, 0, sizeof(*opt));

  while((c = getopt(argc, argv, "p:s:n:f:h")) != -1){
    switch(c){
      case 'p':
        opt->proj = optarg;
        break;
      case 's':
        opt->simplification = strtod(optarg, NULL);
        break;
      case 'n':
        opt->name_field = optarg;
        break;
      case 'f':
        opt->filter = optarg;
        break;
      case '?':
      case 'h':
      default:
        help();
    }
  }

  opt->shpfile = argv[optind];
  if(opt->shpfile == NULL || opt->proj == NULL || opt->name_field == NULL) help();
}

int main(int argc, char **argv){
  opt_t options;
  get_options(&options, argc, argv);

  OGRRegisterAll();
  OGRDataSource *ds;

  ds = OGRSFDriverRegistrar::Open(options.shpfile, FALSE);
  if(ds == NULL) { fprintf(stderr, "Couldn't open datasource %s\n", options.shpfile); exit(1); }

  OGRLayer *layer = ds->GetLayer(0);
  if(layer == NULL) { fprintf(stderr, "No layers in %s", options.shpfile); exit(1); }
  layer->ResetReading();
  int i = 0;

  OGRFeature *feat;
  while((feat = layer->GetNextFeature()) != NULL){
    int field_index = feat->GetFieldIndex(options.name_field);

    if(options.filter != NULL && strcmp(feat->GetFieldAsString(field_index), options.filter) != 0){
      OGRFeature::DestroyFeature(feat);
      continue;
    }

    Shape shape;
    OGRGeometry *geo = feat->GetGeometryRef();
    if(geo == NULL) continue;
    shape.setGeom(geo);
    shape.setProj(options.proj);
    shape.Simplify(options.simplification);

    char *filename;
    if(field_index != -1) {
      asprintf(&filename, "%s.eps", feat->GetFieldAsString(field_index));
    } else {
      asprintf(&filename, "%i.eps", i);
    }

    shape.Render(filename);

    std::cout << "Rendered: " << filename << std::endl;
    free(filename);
    i++;

    OGRFeature::DestroyFeature(feat);
  }

  OGRDataSource::DestroyDataSource(ds);
}
