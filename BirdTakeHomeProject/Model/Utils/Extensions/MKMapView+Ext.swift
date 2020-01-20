//
//  MKMapView+Ext.swift
//  BirdTakeHomeProject
//
//  Created by Sergey Yelmanov on 18.01.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import MapKit

extension MKMapView {

    func annotationView<T: MKAnnotationView>(of type: T.Type, annotation: MKAnnotation?, reuseIdentifier: String) -> T {
        guard let annotationView = dequeueReusableAnnotationView(withIdentifier: reuseIdentifier) as? T else {
            return type.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        }

        annotationView.annotation = annotation
        
        return annotationView
    }

    func fitAll(_ annotations: [MKAnnotation]) {
        var zoomRect = MKMapRect.null

        for annotation in annotations {
            let annotationPoint = MKMapPoint(annotation.coordinate)
            let pointRect = MKMapRect(
                x: annotationPoint.x,
                y: annotationPoint.y,
                width: 0.01,
                height: 0.01
            )
            if zoomRect.isNull {
                zoomRect = pointRect
            } else {
                zoomRect = zoomRect.union(pointRect)
            }
        }

        setVisibleMapRect(
            zoomRect,
            edgePadding: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16),
            animated: true
        )
    }
    
}

