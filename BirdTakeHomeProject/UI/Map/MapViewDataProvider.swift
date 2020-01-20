//
//  MapViewDataProvider.swift
//  BirdTakeHomeProject
//
//  Created by Sergey Yelmanov on 20.01.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import Cluster
import MapKit

protocol MapViewDataProviderDelegate: class {

    func add(annotations: [IdentifableAnnotation])
    func reload()
    func showDetails(withBuilding building: Building)

}

final class MapViewDataProvider: NSObject {

    // MARK: - Properties

    private var buildings = [Building]()
    private(set) var annotations = [IdentifableAnnotation]()
    weak var delegate: MapViewDataProviderDelegate?

    // MARK: - Initializers

    init(buildings: [Building]) {
        self.buildings = buildings
    }

    // MARK: - Adding annotations

    func addAnnotations() {
        buildings.enumerated().forEach { index, building in
            let annotation = IdentifableAnnotation(index: index)
            annotation.coordinate = CLLocationCoordinate2D(latitude: building.latitude, longitude: building.longitude)
            annotations.append(annotation)
        }

        delegate?.add(annotations: annotations)
        delegate?.reload()
    }

}

    // MARK: - Extensions

    // MARK: - Map view delegate

extension MapViewDataProvider: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? ClusterAnnotation {
            return CountClusterAnnotationView(
                annotation: annotation,
                reuseIdentifier: Constants.AnnotationReuseIdentifier.cluster
            )
        } else {
            return BuildingAnnotationView(
                annotation: annotation,
                reuseIdentifier: Constants.AnnotationReuseIdentifier.pin,
                style: .color(UIColor.orange, radius: 8)
            )
        }
    }

    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        delegate?.reload()
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation else { return }

        if let cluster = annotation as? ClusterAnnotation {
            mapView.fitAll(cluster.annotations)
        } else {
            guard let annotation = annotation as? IdentifableAnnotation else { return }

            delegate?.showDetails(withBuilding: buildings[annotation.index])
            mapView.deselectAnnotation(view.annotation, animated: false)
        }
    }

    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        views.forEach { $0.alpha = 0 }

        UIView.animate(
            withDuration: 0.35,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 0,
            options: [],
            animations: {
                views.forEach { $0.alpha = 1 }
            }, completion: nil
        )
    }

}
