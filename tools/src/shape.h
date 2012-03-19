#include <ogr_api.h>
#include <ogr_srs_api.h>
#include <cairo/cairo-ps.h>
#include <ogrsf_frmts.h>

class Shape {
  public:
    Shape();
    ~Shape() { OGRGeometryFactory::destroyGeometry(geom_); };
    void setProj(const char *proj);
    void setGeom(OGRGeometry *geom);
    void Render(const char *path);
    void Simplify(double simplify);
  private:
    OGRGeometry *geom_;
    cairo_t *ctx_;
    double width_;
    double height_;
    void PlotPolygon(OGRPolygon *poly);
    void PlotPart(OGRLinearRing *part);
    void Dispatch(OGRGeometry *geom);
};
