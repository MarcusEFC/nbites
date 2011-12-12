
#include "MemoryViewer.h"
#include <vector>
#include "image/OverlayImage.h"

namespace qtool {
namespace viewer {

using namespace data;
using namespace man::memory;
using namespace qtool::image;

MemoryViewer::MemoryViewer(Memory::const_ptr memory) :
                 memory(memory),
                 image(new BMPYUVImage(memory->getMImage())),
		 overlay(new OverlayImage(memory->getMVision())),
                 roboImageViewer(new RoboImageViewer(image, overlay, this)) {

    this->setCentralWidget(roboImageViewer);
    memory->addSubscriber(roboImageViewer, MIMAGE_ID);
    //corner ownership
    this->setCorner(Qt::TopRightCorner, Qt::RightDockWidgetArea);
    this->setCorner(Qt::BottomRightCorner, Qt::RightDockWidgetArea);

    std::vector<QTreeView> messageViewers;
    for (MObject_ID id = FIRST_OBJECT;
            id != LAST_OBJECT; id++) {
        if (id != MIMAGE_ID) {
            QDockWidget* dockWidget =
                    new QDockWidget(QString(MObject_names[id].c_str()), this);
            MObjectViewer* view = new MObjectViewer(memory->
                    getMObject(id)->getProtoMessage());
            dockWidget->setWidget(view);
            this->addDockWidget(Qt::RightDockWidgetArea, dockWidget);
            memory->addSubscriber(view, id);
        }
    }

}
}
}
