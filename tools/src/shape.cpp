#include "shape.h"
#include <iostream>
#include <assert.h>

Shape::Shape() {
  width_  = 256;
  height_ = 256;
  geom_   = NULL;
}

void Shape::setGeom(OGRGeometry *geom){
  if(geom_ != NULL) OGRGeometryFactory::destroyGeometry(geom);
  geom_ = geom->clone();
  assert(geom_ != NULL);
}

void Shape::setProj(const char *proj) {
  OGRSpatialReference *proj_ = new OGRSpatialReference(NULL);
  OGRErr err = proj_->SetFromUserInput(proj);
  if(geom_->transformTo(proj_) != OGRERR_NONE)
    std::cout << "Couldn't transform shape" << std::endl;
  proj_->Release();
}

static void matrix_init(cairo_matrix_t *mat, double width, double height, OGREnvelope *bounds){
  cairo_matrix_init(mat, 1, 0, 0, -1, 0, 0);
  cairo_matrix_translate(mat, 0, height * -1.0);

  double w,
    bWidth  = fabs(bounds->MaxX - bounds->MinX),
    bHeight = fabs(bounds->MaxY - bounds->MinY);

  if(bWidth > bHeight){
    w = width / bWidth;
  } else {
    w = height / bHeight;
  }

  cairo_matrix_scale(mat, w, w);
  cairo_matrix_translate(mat, -bounds->MinX, -bounds->MinY);
}

// Ripped from simple-tiles
void Shape::PlotPart(OGRLinearRing *ring){
  cairo_move_to(ctx_, ring->getX(0), ring->getY(0));
  for(int i = 0; i < ring->getNumPoints(); i++) {
    cairo_line_to(ctx_, ring->getX(i), ring->getY(i));
  }
}

void Shape::PlotPolygon(OGRPolygon *poly){
  cairo_save(ctx_);
  cairo_new_path(ctx_);
  PlotPart((OGRLinearRing *)poly->getExteriorRing());
  for(int i = 0; i < poly->getNumInteriorRings(); i++) {
    OGRLinearRing *sub = (OGRLinearRing *)poly->getInteriorRing(i);
    PlotPart(sub);
  }
  cairo_close_path(ctx_);
  cairo_fill(ctx_);
  cairo_restore(ctx_);
}

void Shape::Dispatch(OGRGeometry *geom){
  switch(geom->getGeometryType()){
    case wkbPolygon:
    {
      PlotPolygon((OGRPolygon *)geom);
      break;
    }
    case wkbMultiPolygon:
    {
      OGRGeometryCollection *coll = (OGRGeometryCollection *)geom;
      for(int i = 0; i < coll->getNumGeometries(); i++)
        Dispatch(coll->getGeometryRef(i));
      break;
    }
  }
}

void Shape::Simplify(double simplify){
  if(geom_ == NULL) return;

  OGREnvelope env;
  geom_->getEnvelope(&env);

  double w = env.MaxX - env.MinX;
  double h = env.MaxY - env.MinY;

  simplify = simplify / 1000;

  if(w > h) {
    simplify = w * simplify;
  } else {
    simplify = h * simplify;
  }

  OGRGeometry *tmp = geom_->SimplifyPreserveTopology(simplify);
  if(tmp != NULL) {
    OGRGeometryFactory::destroyGeometry(geom_);
    geom_ = tmp;
  }
}

void Shape::Render(const char *path){
  if(geom_ == NULL) return;
  cairo_surface_t *surface = cairo_ps_surface_create(path, width_, height_);
  if(cairo_surface_status(surface) != CAIRO_STATUS_SUCCESS) {
    std::cout << cairo_status_to_string(cairo_surface_status(surface)) << std::endl;
    exit(1);
    return;
  }

  ctx_ = cairo_create(surface);

  OGREnvelope env;
  geom_->getEnvelope(&env);
  cairo_matrix_t mat;
  matrix_init(&mat, width_, height_, &env);
  cairo_set_matrix(ctx_, &mat);

  Dispatch(geom_);

  cairo_show_page(ctx_);
  cairo_destroy(ctx_);
  cairo_surface_destroy(surface);
}
