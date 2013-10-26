/**
 * Created by IntelliJ IDEA 12
 * Date: 15.04.13
 * Author: Daniil Subbotin
 * Email: subdan@me.com
 */
package ru.subdan.fae.model
{
	import com.junkbyte.console.Cc;

	import ru.subdan.fae.model.vos.TrackVO;

	public class TracksModel
	{
		private var _tracks:Vector.<TrackVO> = new <TrackVO>[];
		private var _numOfTracks:int;

		public var currentTrack:TrackVO;

		public function addTrack(track:TrackVO):void
		{
			CONFIG::debug { Cc.add("TracksModel: добавлен новый трек c ID = " + track.id);}
			_tracks.push(track);
			_numOfTracks++;
			currentTrack = track;
		}

		public function getTrack(id:String):TrackVO
		{
			for (var i:int = 0; i < _numOfTracks; i++)
				if (_tracks[i].id == id)
					return _tracks[i];

			return null;
		}

		public function deleteTrack(id:String):void
		{
			for (var i:int = 0; i < _numOfTracks; i++)
			{
				if (_tracks[i].id == id)
				{
					CONFIG::debug { Cc.add("TracksModel: удален трек c ID = " + _tracks[i].id);}
					_tracks[i].free();
					_tracks.splice(i, 1);
					_numOfTracks--;
				}
			}
		}

		public function get tracks():Vector.<TrackVO>
		{
			return _tracks;
		}
	}
}
