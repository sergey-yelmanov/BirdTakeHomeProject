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
    
}

