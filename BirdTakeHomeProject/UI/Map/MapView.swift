//
//  MapView.swift
//  BirdTakeHomeProject
//
//  Created by Sergey Yelmanov on 17.01.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import UIKit
import MapKit
import Cluster

final class MapView: UIView {

    // MARK: - Properties

    var mapView: MKMapView!

    // MARK: - Private properties

    private var manager: ClusterManager!

    // MARK: - Initializers

    init(buildings: [Building]) {
        super.init(frame: .zero)

        configure()
        addAnnotations(withBuildings: buildings)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configuration

    private func configure() {
        configureMapView()
        configureClusterManager()
    }

    private func configureMapView() {
        mapView = MKMapView()
        mapView.delegate = self
        mapView.pointOfInterestFilter = .excludingAll

        addSubview(mapView)

        mapView.pin(to: self)

        let region = (center: CLLocationCoordinate2D(latitude: 50.45466, longitude: 30.5238), delta: 0.07)

        mapView.region = MKCoordinateRegion(
            center: region.center,
            span: MKCoordinateSpan(latitudeDelta: region.delta, longitudeDelta: region.delta)
        )
    }

    private func configureClusterManager() {
        manager = ClusterManager()
        manager.maxZoomLevel = 17
        manager.minCountForClustering = 3
        manager.clusterPosition = .average
    }

    // MARK: - Adding annotations

    private func addAnnotations(withBuildings buildings: [Building]) {
        var annotations = [Annotation]()

        buildings.forEach {
            let annotation = Annotation()
            annotation.title = $0.name
            annotation.coordinate = CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude)
            annotations.append(annotation)
        }

        manager.add(annotations)
        manager.reload(mapView: mapView)
    }

}

    // MARK: - Extensions

    // MARK: - Map view delegate

extension MapView: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? ClusterAnnotation {
            return CountClusterAnnotationView(annotation: annotation, reuseIdentifier: "cluster")
        } else {
            return BuildingAnnotationView(
                annotation: annotation,
                reuseIdentifier: "pin",
                style: .color(UIColor.orange, radius: 8)
            )
        }
    }

    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        manager.reload(mapView: mapView) { _ in }
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation else { return }

        if let cluster = annotation as? ClusterAnnotation {
            var zoomRect = MKMapRect.null
            for annotation in cluster.annotations {
                let annotationPoint = MKMapPoint(annotation.coordinate)
                let pointRect = MKMapRect(x: annotationPoint.x, y: annotationPoint.y, width: 0, height: 0)
                if zoomRect.isNull {
                    zoomRect = pointRect
                } else {
                    zoomRect = zoomRect.union(pointRect)
                }
            }
            mapView.setVisibleMapRect(zoomRect, animated: true)
        } else {
            print("==============")
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
